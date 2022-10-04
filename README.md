# ref-match-db: Create mash sketch databases for referenceseeker

## Background

Identifying an appropriate reference genome for use in pathogen genomics is an 
important first step in many analyses. 

## Requirements

* Nextflow
* Conda or Docker

## Usage

Run a test with Conda:

```bash
nextflow run lgi-onehealth/ref-match-db -profile test,conda
```

Run a test with Docker:

```bash
nextflow run lgi-onehealth/ref-match-db -profile test,docker
```

