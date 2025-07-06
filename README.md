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

### Code Linting

To automate code quality and readability, I installed sqlfluff using `pip install sqlfluff-templater-dbt` to lint the sql using the default [sqlfluff dbt templater](https://docs.sqlfluff.com/en/stable/configuration/templating/dbt.html) rules.

**Note:** If the repo was to be used by multiple engineers in a team and in a production pipeline, these Python packages could be added to a requirements.txt or a Docker image.


## Data Exploration

With set up successful, I explored the data provided.

## Data Modeling

I set up the initial folder structure as per some [dbt best practices](https://docs.getdbt.com/best-practices). In practice the structure and naming conventions would also depend on patterns agreed up front by the team.


## Assumptions

## Other Considerations

 The scope and output of this exercise has been limited given the time constraints and the expectation that the code is not to be production ready. The following requirements would normally be considered and discussed for production pipelines: 

- Data governance
- Data classification
- Data testing:

 Leverage dbt packages to test at a column for example [dbt tests](https://docs.getdbt.com/docs/build/data-tests) and the [great expectations package]( https://github.com/calogica/dbt-expectations/tree/0.10.3/),  unit test sql models using [dbt unit tests](https://docs.getdbt.com/docs/build/unit-tests) or write customised data tests.

 - dbt macros and macro unit tests where necessary
 - Automated pipeline scheduling
 - Pipeline monitoring tools

