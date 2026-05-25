# ---------------------------------------------------------------------------
# Smoke-test override – 2026-05-25 weekend validation run.
#
# USAGE
#   Apply smoke-test value:
#     terraform apply -var-file="smoke_test.tfvars"
#
#   Revert to stable default – simply omit this var-file:
#     terraform apply
#
# WARNING – DO NOT COMMIT THIS FILE
#   This file is an ephemeral, time-scoped override. Before committing,
#   add it to .gitignore:
#
#     echo 'smoke_test.tfvars' >> .gitignore
#
#   Committing it pollutes repo history with a stale, date-stamped artifact
#   and risks accidentally re-applying the smoke-test value in future CI
#   runs if a pipeline passes this file automatically.
#
# Do NOT merge these values into variables.tf defaults.
# ---------------------------------------------------------------------------

sns_display_name = "SmokeTest-2026-05-25"
