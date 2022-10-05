# ref-match-db: Create mash sketch databases for referenceseeker

## Background

Identifying an appropriate reference genome for use in pathogen genomics is an 
important first step in many analyses. One approach to quickly identify a potentially
suitable reference is to use minhash sketches of possible genomes and compare these to
minhash sketches of one or more of the samples of interest. However, creating and 
maintaining a database of minhash sketches for all possible references is both time
consumming and space intensive. The size of the database also makes it hard to use in 
workflows run on the cloud or in other situations where the database must be downloaded 
on the fly for use during runtime. This tool automates the process of creating a mash
sketch databases that are targetted for the organism of interest. By making the databases
targetted, they are much smaller and can be easily created on the fly, thus always being
up to date.

Here, we combine the tools `ncbi-genome-download` (Blin 2016) and `referenceseeker` 
(Schwengers _et al._ 2020) to download relevant genomes from NCBI and create a mash sketch
database for use with `referenceseeker`. The workflow was built using the principles, 
modules, and tools from the `nf-core` community (Ewels _et al._ 2020).

## Requirements

* Nextflow
* Conda or Docker

## Usage

### Running a quick test

The test will create a database for _Salmonella enterica_ subsp. _enterica_ 
serovar Dublin. This shows that the databases can be quite specific. 

Run a test with Conda:

```bash
nextflow run lgi-onehealth/ref-match-db -profile test,conda
```

Run a test with Docker:

```bash
nextflow run lgi-onehealth/ref-match-db -profile test,docker
```

### Running the pipeline

The primary parameter that most users will be concerned with is the `--organisms`
parameter. This parameter is used to specify the organism of interest. The 
`--organisms` parameter is passed directly to `ncbi-genome-download` `--genera` 
parameter and so can be anything that is acceptable for that tool.

For example, to create a database of _Neisseria_ genomes, run:

```bash
nextflow run lgi-onehealth/ref-match-db --organisms "Neisseria" -profile docker
```

The pipeline will create a directory called `databases` in the current working directory, and in it will create a directory for each organism specified. In each organism directory, there will be `referenceseeker` database.

Multiple organisms can be specified by separating them with a comma:

```bash
nextflow run lgi-onehealth/ref-match-db --organisms "Listeria monocytogenes,Neisseria" -profile docker
```

This will run the pipeline in parallel for each organism, creating individual
databases for each organism.

To create databases for specific _Salomonella_ serovars, use the `--organisms` parameter with the following format:

```bash
nextflow run lgi-onehealth/ref-match-db --organisms "Salmonella enterica subsp. enterica serovar Dublin" -profile docker
```

## Workflow parameters

The following parameters are available for the pipeline:

| Parameter          | Description                          | Default                                              |
| ------------------ | ------------------------------------ | ---------------------------------------------------- |
| `--organisms`      | Organism(s) to create databases for. | `Salmonella enterica subsp. enterica serovar Dublin` |
| `--outdir`         | Output directory for the databases.  | `databases`                                          |
| `--assembly-level` | Assembly level to download.          | `complete`                                           |
| `--group`          | Group to download                    | `bacteria`                                           |

The `--assembly-level` and `--group` parameters are passed directly to `ncbi-genome-download` and so can be anything that is acceptable for that tool.
Possible values can be found in the `ncbi-genome-download` [documentation](https://github.com/kblin/ncbi-genome-download).

## References

Blin, K (2016) ncbi-genome-download (version 0.3.1) [Source code]. [https://github.com/kblin/ncbi-genome-download](https://github.com/kblin/ncbi-genome-download/)

Ewels, P. A., Peltzer, A., Fillinger, S., Patel, H., Alneberg, J., Wilm, A., Garcia, M. U., Di Tommaso, P., & Nahnsen, S. (2020). The nf-core framework for community-curated bioinformatics pipelines. Nature Biotechnology, 38(3), 276–278. [https://doi.org/10.1038/s41587-020-0439-x](https://doi.org/10.1038/s41587-020-0439-x)

Schwengers, O., Hain, T., Chakraborty, T., & Goesmann, A. (2020). ReferenceSeeker: rapid determination of appropriate reference genomes. Journal of Open Source Software, 5(46), 1994. [https://doi.org/10.21105/joss.01994](https://doi.org/10.21105/joss.01994)