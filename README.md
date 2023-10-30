# Datadrivers PlantUML Cloud Icon Set

## Usage

```
@startuml

!include https://raw.githubusercontent.com/datadrivers/plantuml_cloud_icon_set/main/templates/GCP.puml
!include https://raw.githubusercontent.com/datadrivers/plantuml_cloud_icon_set/main/templates/AZURE.puml

!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Component.puml

HIDE_STEREOTYPE()


frame "Example" {

  Person(p1, "Administrator")

  Boundary(org, "Organization", $type="organization") {
    Boundary(billing, "Billing", $type="cloud management unit") {
      System(gcp_billing_reporting, "Billing\nProject", "GCP Billing", $type="resource management unit", $sprite=$GCP_BILLING_BILLING)
      System(gcp_billing_cf, "Cost Notification Cloud Function", "Cloud Function to exchange cost inforamtion", $type="GCP service", $sprite=$GCP_CLOUD_FUNCTIONS_CLOUD_FUNCTIONS)
      System(azure_billing_reporting, "Billing\nProject", "Azure Billing", $type="resource management unit", $sprite=$AZURE_GENERAL_COST_MANAGEMENT_AND_BILLING)
    }

    BiRel_R(azure_billing_reporting, gcp_billing_cf, "Data Exchange")
    BiRel_R(gcp_billing_cf, gcp_billing_reporting, "Data Exchange")
  }

  Rel(p1, gcp_billing_reporting, "monitors")
}

footer last updated: %date("dd.MM.yyyy")

@enduml
```

```
cat example.puml | java -Djava.awt.headless=true -jar plantuml.jar -tsvg -p | inkscape -b white -d 400 -p -o example.png
```
results in: 


![example.png](example.png)

## Contains Icons for the following Cloud Provider

- [Azure](AZURE.md)
- [GCP](GCP.md)
