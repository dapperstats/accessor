# Access Access<sup>&reg;</sup> Databases without Access to Access<sup>&reg;</sup>

[![docker](https://github.com/dapperstats/accessor/actions/workflows/docker.yaml/badge.svg)](https://github.com/dapperstats/accessor/actions/workflows/docker.yaml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Lifecycle:maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3611911.svg)](https://doi.org/10.5281/zenodo.3611911)

<img src="imgs/logo.png" width="200px" align="right" alt="hexagon software logo, black border with pale bold light red background and general color schema, somewhat, but not exactly, matching that of Access. there is a database stack symbol on the right with shades of red and then a series of small gridded empty tables with white background and blue header background in the left middle. the word accessor is in a rounded rectangular box in the middle upper part of the logo. white text.">

Tools for accessing Access<sup>&reg;</sup> databases in the absence of access to Access<sup>&reg;</sup>.

The focal component of `accessor` (unlocking the Access<sup>&reg;</sup> database) is built on top of [`mdbtools`](http://mdbtools.sourceforge.net/) and [`unixodcb`](http://www.unixodbc.org/) software libraries and consists of a set of bash scripts with options that allow the user to target a remote (`-r`) or local (`-l`) database.

A folder (named after the database) is created and populated with `.csv` files (one for each table, named accordingly) which can then optionally be read into [`R`](https://www.r-project.org/) using a set of generalized functions. 

We package `accessor` into a stable yet flexible [`Docker`](https://www.docker.com) [software container](https://www.docker.com/resources/what-container), as written out in the [`Dockerfile`](https://github.com/dapperstats/accessor/blob/main/Dockerfile) and with an available image on [Docker Hub](https://hub.docker.com/r/dapperstats/accessor). 

Default settings are for the [California Delta](https://en.wikipedia.org/wiki/Sacramento%E2%80%93San_Joaquin_River_Delta) [fish salvage database](https://wildlife.ca.gov/Conservation/Delta/Salvage-Monitoring) (as implemented in the [`salvage` repo](https://github.com/dapperstats/salvage/)) but users can specify any remote or local database to be converted to `.csv`s and can automate loading of the data into `R` via command line options. 

See the [`methods description`](https://github.com/dapperstats/accessor/blob/main/documents/methods.md) for more details and the [`salvage` repo](https://github.com/dapperstats/salvage/) to see `accessor` in action.

## Authors and Version Info

[**J. L. Simonis**](https://orcid.org/0000-0001-9798-0460) of [DAPPER Stats](https://www.dapperstats.com)

v0.4.1

If you are interested in contributing, see the [Contributor Guidelines](https://github.com/dapperstats/salvage/blob/main/CONTRIBUTING.md) and [Code of Conduct](https://github.com/dapperstats/salvage/blob/main/CODE_OF_CONDUCT.md).

[DAPPER Stats](https://www.dapperstats.com) provides this software under the [MIT License](https://opensource.org/licenses/MIT). If you are interested in applying the code to your own Access<sup>&reg;</sup>-associated situation, please [contact us](https://www.dapperstats.com/contact/)!