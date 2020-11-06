output "id" {
	description = "An identifier for the resource with format projects/{{project}}/instances/{{instance}}/databases/{{name}}"
  value = google_sql_database.database.id
}

output "self_link" {
	description = "The URI of the created resource."
	value = google_sql_database.database.self_link
}

output "database_name" {
	description = "The name of the database created in the Cloud SQL instance."
	value = google_sql_database.database.name
}
