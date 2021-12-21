#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#  args:
#  args: :org
#
#  Author: Hari Sekhon
#  Date: 2021-12-21 13:30:39 +0000 (Tue, 21 Dec 2021)
#
#  https://github.com/HariSekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(dirname "${BASH_SOURCE[0]}")"

# shellcheck disable=SC1090
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Lists Terraform Cloud variable sets for a given organization

Output:

<id>    <name>
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="[<organization>]"

help_usage "$@"

#min_args 1 "$@"

org="${1:-${TERRAFORM_ORGANIZATION:-}}"

if [ -z "$org" ]; then
    usage "no terraform organization given and TERRAFORM_ORGANIZATION not set"
fi

"$srcdir/terraform_cloud_api.sh" "/organizations/$org/varsets" |
jq -r '.data[] | [.id, .attributes.name] | @tsv'