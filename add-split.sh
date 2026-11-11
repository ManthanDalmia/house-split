#!/bin/zsh
# Add a House Split expense from the Mac terminal.
# Setup: export SPLIT_URL='<the URL_ value from the app's "Add from iPhone" script>'  (put it in ~/.zshrc)
# Usage: ./add-split.sh <amount> "<note>" <Category> [flatmate ...]
#   ./add-split.sh 450 "Blinkit milk" Grocery Ashish Parth
# Include your own name (e.g. Manthan) in the list if you're part of the split; leave it out to exclude yourself.
# Categories: Grocery, Instahelp, "Urban Company", Entertainment, "Online product", "Food & delivery", Utilities, Travel, Other
[ -z "$SPLIT_URL" ] && { echo "Set SPLIT_URL first (see header)"; exit 1; }
[ $# -lt 3 ] && { sed -n '5,7p' "$0"; exit 1; }
body=$(python3 -I - "$@" <<'PY'
import sys, json, datetime
amount, note, tag, *people = sys.argv[1:]
print(json.dumps({"fields": {
    "amount": {"doubleValue": float(amount)},
    "note": {"stringValue": note[:80]},
    "tag": {"stringValue": tag},
    "date": {"stringValue": datetime.date.today().isoformat()},
    "custom": {"stringValue": ""},
    "people": {"arrayValue": {"values": [{"stringValue": p} for p in people]}}}}))
PY
) || exit 1
res=$(curl -s -X POST -H 'Content-Type: application/json' -d "$body" "$SPLIT_URL")
echo "$res" | grep -q '"name"' && echo "Added ✓ — open the app to see it" || echo "Failed: $res"
