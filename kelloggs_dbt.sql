Demo_Repo:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: "{{ env_var('WKJRRHC-TD27391') }}"
      user: "{{ env_var('DBT_USER') }}"
      password: "{{ env_var('YourStrongPassword123') }}"
      role: DBT_ROLE
      database: DBT_DB
      warehouse: DBT_WH
      schema: DBT_SCHEMA
      threads: 6