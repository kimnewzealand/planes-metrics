# Summary 

The goal is to solve the business problem:

"Client wants a flights data mart designed and deployed on Snowflake to support downstream reporting on flights occurred."

I made assumptions given the time and available information constraints. In a real business project I would work with the team to validate any assumptions, and requirements with stakeholders in the design prior to build.

See below a summary of the steps I took with proposed solutions.

## High Level Requirements

In order to make a new environment easy to use by both engineers and data analysts, the new environment would have the following requirements:

### Automation

- Automated process steps and processes leveraging available tools and packages

### Documention

- Clear documented steps for environment set up for engineers
- Consistent and intuitive naming conventions for models and columns
- Meaningful model level and column descriptions for data analysts 

### Costs

Any new tooling would need to be cost effective and be within budget, with a  preference for open source tooling.

## Technical Design

The following is a proposed technical design and architecture for this new environment:

- Data Ingress 

Initial data load was performed loading static csv files to Snowflake. An ingress tool such as Kafka or Fivetran could be used depending on the budget, data availability and reporting requirements.

- Database Storage

Snowflake is the enterprise tool for storage and maintaining access, usage monitoring, governance and security. Snowflake offers roles based access controls to restrict user access at schema or table or column level and warehouses to manage compute. 

- Data Transformation

dbt core is an open source tool used for the data transformation using SQL which is easy for engineers and analysts to follow. dbt and dbt related packages leveraging dbt's documentation browser feature to view data lineage and documentation. Additionally dbt supports software engineering practices to add data testing and macro unit testing, automate the testing and other steps in continuous integration (CI) / continuous deployment (CD)  using GitHub Actions and collaboration with version control code using GitHub. An alternative is dbt cloud which a paid version of dbt.

- Data Orchestration

In order to schedule this as a data pipeline in pre production or production environments with alerting,  a tool such as Airflow or Prefect could be used depending on budget.

- Data Observability

An open source tool such as Elementary or a subscription tool such as Monte Carlo can be used for observability of data quality and performance of the pipeline also with alerting capabilities. These tools also offer anomaly detection.

- Data Reporting

It is assumed that an enterprise BI tool such as Power BI would be used for dashboard and reporting data products and that final mart data models would be ease to load with as little manipulation required by data analysts as possible in this final step.

## Initial Setup

I had recently upgraded to Python 3.13 on my personal laptop but I needed to install 3.12 for compatibility with dbt-core versions.
[What version of Python can I use?](https://docs.getdbt.com/faqs/Core/install-python-compatibility)

After creating a Snowflake trial account and loading in the provided csvs, I installed the dbt-core snowflake adapter using a requirements.txt file.

I then created a profiles.yml using `dbt init` to connect dbt-core to the trial account.

I set up the initial folder structure as per [dbt best practices](https://docs.getdbt.com/best-practices). In practice the structure and naming conventions would also depend on patterns agreed up front by the team.

To automate code quality and readability, I installed sqlfluff for dbt to lint the sql using the default [sqlfluff dbt templater](https://docs.sqlfluff.com/en/stable/configuration/templating/dbt.html) rules.

A Docker image using the requirements.txt could also be used for reproduceability  and conflict management between engineers and across environments.

## Data Exploration

With set up successful, I explored the data provided to identify the grain and keys for each source to model the data.

See ``./data_modeling/data_exploration.py``

## Data Modeling

See physical data model using https://dbdiagram.io/d

<img src='./data_modeling/physical_data_model_dbdiagramio.png'>

Based on the information provided I have created big wide tables for use by data analysts for reporting.

The benefits of big wide tables are :
- Simplified tables are easy to understand. Complex joins already done in the transformation layer without analysts having overhead to understand star schema or dimensional modeling
- All available dimensions available in a single table ready to filter or group
- Easy to aggregate or transform further into metrics if needed
- Query performant in BI tooling.

On inspection of the intermediate models there appears to be some data issues to be investigated further given time:
- missing destination faa_id's from the airports dataset. See failing unique_combination_of_columns in stg_weather.yml test. Source potentially needs deduping.
- missing planes metadata from the planes dataset. Source data is potentially missing data.
- missing weather data, the weather_id key may not be correct yet and may need to be at hours.

## Next steps

 The scope and output of this exercise has been limited given the time constraints and the expectation that the code is not to be production ready.
 
 The following requirements could be considered and discussed to productionise this code as a data product: 

- Data testing:

 Leverage dbt packages to test further at a column for example [dbt tests](https://docs.getdbt.com/docs/build/data-tests) and the [great expectations package]( https://github.com/calogica/dbt-expectations/tree/0.10.3/),  unit test sql models using [dbt unit tests](https://docs.getdbt.com/docs/build/unit-tests), enforce data contracts, add constraints or to write customised data tests.

- GitHub Actions

Add workflows with dbt commands, tags and targets to the repo.

