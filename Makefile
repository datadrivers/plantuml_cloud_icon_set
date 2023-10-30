all:GCP_ICONS.puml AZURE_ICONS.puml

GCP_ICONS.puml:google-cloud-icons
	/bin/bash scripts/convert-svg-to-puml.sh GCP google-cloud-icons

AZURE_ICONS.puml:azure-cloud-icons
	/bin/bash scripts/convert-svg-to-puml.sh AZURE azure-cloud-icons

azure-cloud-icons:
	curl -LO https://arch-center.azureedge.net/icons/Azure_Public_Service_Icons_V17.zip 
	unzip Azure_Public_Service_Icons_V17.zip -d azure-cloud-icons
	rm Azure_Public_Service_Icons_V17

google-cloud-icons:
	curl -L https://cloud.google.com/static/icons/files/google-cloud-icons.zip --output google-cloud-icons.zip
	unzip google-cloud-icons.zip -d google-cloud-icons
