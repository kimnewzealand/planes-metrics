# Summary 

The goal is to solve the business problem:

"Client wants a flights data mart designed and deployed on Snowflake to support downstream reporting on flights occurred."

I made assumptions given the time and available information constraints. In a real business project I would work with the team to validate any assumptions, and requirements with stakeholders and users prior to building the models.

See below a summary of the steps I took with lists of challenges, proposed solutions, assumptions and open questions.

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

I finally installed sqlfluff to lint the sql using `pip install sqlfluff-templater-dbt`

**Note:** these Python package versions could be added to a requirements.txt if the repo was to be used by multiple engineers in practice.


## Data Exploration

With set up successful, I explored the data provided.

## Data Modeling

I set up the folder structure as per [https://docs.getdbt.com/best-practices](dbt best practices) but structure and naming conventions also depend on  patterns decided by the team.

## Data Testing

We could add dbt generic tests (https://docs.getdbt.com/docs/build/data-tests) to test for data validity and quality of the source data.

- not nulls to ensure that the data is complete

We could add other dbt or even leverage the great expectations package ( https://github.com/calogica/dbt-expectations/tree/0.10.3/) for shape, values, types, range, summary statistics etc depending on further discussions and requirements.

## Open Questions

## Assumptions

- Data governance and data classification should be considered in a data pipeline production context but out of scope of this exercise.

