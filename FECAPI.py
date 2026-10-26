import requests
import os
import pandas as pd

url = "https://api.open.fec.gov/v1/candidates/"
CANDIDATE_FIELDS = [
    "candidate_id", 
    "name", 
    "party_full", 
    "state", 
    "office", 
    "election_year", 
    "status"
]
params = {
    "contributor_state": "VA",
    "min_amount": 1000,
    "two_year_transaction_period": 2026,
    "api_key": "2O37DmX4vMDeaBbxDsMtJCiMW8OSZRX7JabOu4Uk",
    "per_page": 20
}
response = requests.get(url, params=params)
response_dict=response.json()['results']


# 1. Check if the HTTP request itself succeeded (e.g., 200 OK)
if response.status_code != 200:
    print(f"Error {response.status_code}: Server returned a bad status.")
    print("Raw Response Context:")
    print(response.text)  # This will print the actual text/HTML causing the crash

else:
    try:
        # 2. Safely parse JSON if the status is 200
        data = response.json()
        print(data)
    except requests.exceptions.JSONDecodeError:
        print("Received 200 OK, but the body was not valid JSON:")
        print(response.text)
        






data = response.json()


















BASE = "https://api.open.fec.gov/v1/schedules/schedule_a/"
params = {
    "api_key": "2O37DmX4vMDeaBbxDsMtJCiMW8OSZRX7JabOu4Uk",  
    "contributor_name": "Tseng, Brandon",
    "contributor_employer": "Shield AI",
    "two_year_transaction_period": 2026,  # covers 2025-2026 (119th Congress)
    "min_date": "2025-01-03",             # 119th Congress convened
    "max_date": "2027-01-03",             # ...and ends
    "is_individual": "true",
    "sort": "-contribution_receipt_date",
    "per_page": 100,
}

results = []
while True:
    r = requests.get(BASE, params=params)
    r.raise_for_status()
    data = r.json()
    results.extend(data["results"])

    last = data["pagination"].get("last_indexes")
    if not last:
        break
    params["last_index"] = last["last_index"]
    params["last_contribution_receipt_date"] = last["last_contribution_receipt_date"]

for c in results:
    print(
        c["contribution_receipt_date"],
        c["contributor_name"],
        c["contributor_employer"],
        c["contribution_receipt_amount"],
        "->",
        c["committee"]["name"],
    )






import os
import requests
import pandas as pd

BASE = "https://api.open.fec.gov/v1/schedules/schedule_a/"
params = {
    "api_key":"2O37DmX4vMDeaBbxDsMtJCiMW8OSZRX7JabOu4Uk",
    "contributor_name": "Tseng, Brandon",
    "contributor_employer": "Shield AI",
    "two_year_transaction_period": 2026,
    "min_date": "2025-01-03",
    "max_date": "2027-01-03",
    "is_individual": "true",
    "sort": "-contribution_receipt_date",
    "per_page": 100,
}

rows = []
while True:
    r = requests.get(BASE, params=params)
    r.raise_for_status()
    data = r.json()

    for c in data["results"]:
        cm = c.get("committee") or {}
        rows.append({
            "date": c["contribution_receipt_date"],
            "donor": c["contributor_name"],
            "employer": c["contributor_employer"],
            "amount": c["contribution_receipt_amount"],
            "recipient": cm.get("name"),
            "committee_id": c.get("committee_id"),
            "committee_type": cm.get("committee_type_full"),
            "party": cm.get("party"),            # e.g. "DEM", "REP"
            "party_full": cm.get("party_full"),  # e.g. "DEMOCRATIC PARTY"
            "conduit": c.get("conduit_committee_name"),
            "memo": c.get("memo_code"),
        })

    last = data["pagination"].get("last_indexes")
    if not last:
        break
    params["last_index"] = last["last_index"]
    params["last_contribution_receipt_date"] = last["last_contribution_receipt_date"]

df = pd.DataFrame(rows)
print(df.to_string(index=False))

print(df[df["memo"].isna()].groupby("party_full", dropna=False)["amount"].sum())


df[['recipient', 'party']]
