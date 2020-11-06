resource "google_sql_database" "database" {
	name = var.database_name
	instance = var.instance_name
}
