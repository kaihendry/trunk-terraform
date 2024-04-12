project:
	gcloud config get project

enabledapis:
	gcloud services list --enabled

projectid:
	gcloud projects describe $(gcloud config get-value core/project) --format=value\(projectNumber\)
