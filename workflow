name: Deploy Cloud Armor Policy testing

on:
  push:
    branches:
      - main
    paths:
      - '**/cloud_armor_policy.yml'

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up gcloud CLI
      uses: google-github-actions/setup-gcloud@v0.3.0
      with:
        project_id: ${{ secrets.GCP_PROJECT_ID }}
        service_account_key: ${{ secrets.GCP_SA_KEY }}
        export_default_credentials: true
        
    - name: Deploy Cloud Armor Policy
      run: |
          gcloud compute security-policies create abhishek-cloud-armor-policy \
            --config=cloud_armor_policy.yml
