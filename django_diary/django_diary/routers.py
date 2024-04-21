class MyDatabaseRouter:
    def allow_migrate(self, db, app_label, model_name=None, **hints):
        # Example logic: Allow migrations for the 'myapp' app on the 'default' database only
        if app_label == 'api':
            return db == 'default'
        # For all other apps and databases, the router has no opinion
        return None