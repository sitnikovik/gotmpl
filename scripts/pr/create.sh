#!/bin/sh

set -eu

pr_type="${1:-}"
pr_arg="${2:-}"

repo_root=$(git rev-parse --show-toplevel)
template_dir="$repo_root/.github/PULL_REQUEST_TEMPLATE"
template_path="$template_dir/$pr_type.md"

if ! command -v gh >/dev/null 2>&1; then
	echo "gh CLI is required to create pull requests" >&2
	exit 1
fi

if [ -z "${GH_TOKEN:-}" ] && [ -n "${GITHUB_TOKEN:-}" ]; then
	GH_TOKEN="$GITHUB_TOKEN"
	export GH_TOKEN
fi

if [ -z "${GH_TOKEN:-}" ]; then
	echo "Set GH_TOKEN or GITHUB_TOKEN before running make pr" >&2
	exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
	echo "gh authentication failed for the provided GitHub token" >&2
	exit 1
fi

if [ ! -f "$template_path" ]; then
	echo "PR template not found: $template_path" >&2
	exit 1
fi

current_branch=$(git branch --show-current)

if [ -z "$current_branch" ]; then
	echo "Unable to detect current git branch" >&2
	exit 1
fi

temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT HUP INT TERM

case "$pr_type" in
	feature|bug|task)
		case "$pr_arg" in
			''|*[!0-9]*)
				echo "Issue identifier must be numeric for $pr_type PRs" >&2
				exit 1
				;;
		esac

		issue_title=$(gh issue view "$pr_arg" --json title --jq '.title')
		sed \
			-e "s/{{ISSUE_NUMBER}}/$pr_arg/g" \
			-e "s/{{ISSUE_TITLE}}/$issue_title/g" \
			"$template_path" > "$temp_file"
		pr_title="$pr_type: #$pr_arg $issue_title"
		;;
	release)
		sed -e "s/{{VERSION}}/$pr_arg/g" "$template_path" > "$temp_file"
		pr_title="release: $pr_arg"
		;;
	*)
		echo "Unsupported PR type: $pr_type" >&2
		exit 1
		;;
esac

gh pr create \
	--base master \
	--head "$current_branch" \
	--title "$pr_title" \
	--body-file "$temp_file"