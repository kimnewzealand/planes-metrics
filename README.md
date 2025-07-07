# Summary 

The goal is to solve the business problem:

"Client wants a flights data mart designed and deployed on Snowflake to support downstream reporting on flights occurred."

I made assumptions given the time and available information constraints. In a real business project I would work with the team to validate any assumptions, and requirements with stakeholders and users prior to building the models.

See below a summary of the steps I took with proposed solutions.

## Setup

I have only used dbt-core so I decided to use this package over trialing dbt cloud for the data transformation steps.

I had recently upgraded to Python 3.13 on my personal laptop but I needed to install 3.12 for compatibility with dbt-core versions.
[What version of Python can I use?](https://docs.getdbt.com/faqs/Core/install-python-compatibility)

After creating a Snowflake trial account and loading in the provided csvs, I installed the dbt-core snowflake adapter with ` python -m pip install dbt-core dbt-snowflake` 

```
$ dbt --version
Core:
  - installed: 1.10.3
  - latest:    1.10.3 - Up to date!
```

I then created a profiles.yml using `dbt init` to connect dbt-core to the trial account.

I set up the initial folder structure as per [dbt best practices](https://docs.getdbt.com/best-practices). In practice the structure and naming conventions would also depend on patterns agreed up front by the team.

### Code Linting

To automate code quality and readability, I installed sqlfluff using `pip install sqlfluff-templater-dbt` to lint the sql using the default [sqlfluff dbt templater](https://docs.sqlfluff.com/en/stable/configuration/templating/dbt.html) rules.

**Note:** If the repo was to be used by multiple engineers in a team and in a production pipeline, these Python packages could be added to a requirements.txt or a Docker image.


## Data Exploration

With set up successful, I explored the data provided to identify the grain and keys for each source to model the data.

See ./data_modeling/data_exploration.py

## Data Modeling

See physical data model using https://dbdiagram.io/d

<img src='./data_modeling/physical_data_model_dbdiagramio.png'>

Based on the information provided I have created big wide tables.
The benefits are that these tables could be used for for downstream reporting users who potentially want ready joined data that can be aggregated in the mart as required to load into and be performant in BI tooling.

On inspection of the intermediate models there appears to be some issues:
- missing destination faa_id's from the airports dataset
- missing planes metadata from the planes dataset
- missing weather data, the weather_id key may not be correct yet. See failing unique_combination_of_columns in stg_weather.yml test

## Other Considerations

 The scope and output of this exercise has been limited given the time constraints and the expectation that the code is not to be production ready.
 
 The following requirements could be considered and discussed to productionise this code as a data product: 

- Data governance
- Data classification
- Data testing:
 Leverage dbt packages to test further at a column for example [dbt tests](https://docs.getdbt.com/docs/build/data-tests) and the [great expectations package]( https://github.com/calogica/dbt-expectations/tree/0.10.3/),  unit test sql models using [dbt unit tests](https://docs.getdbt.com/docs/build/unit-tests) or to write customised data tests.

 - Automated pipeline scheduling
 - Pipeline monitoring tools

