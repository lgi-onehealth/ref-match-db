process REFERENCESEEKER_DB {
    tag "$organism"
    label 'process_low'

    conda (params.enable_conda ? "bioconda::referenceseeker=1.8.0" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/referenceseeker:1.8.0--pyhdfd78af_0':
        'quay.io/biocontainers/referenceseeker:1.8.0--pyhdfd78af_0' }"

    input:
    tuple val(organism), path(fasta), path(metadata)

    output:
    tuple val(organism),path("db.msh"), path("db.tsv"), emit: db
    path "versions.yml"                                     , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    
    """
    referenceseeker_db init --db db
    sed 1d $metadata \\
     | cut -f1,9,10 -d\$'\t' \\
     | while IFS=\$'\t' read -r accession taxid organism; do 
        referenceseeker_db import \\
        --db db \\
        --genome \$accession*.fna.gz \\
        --id \$taxid \\
        --status complete \\
        --organism \"\$organism\"; 
        done
        mv db/* .

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        referenceseeker: \$(echo \$(referenceseeker --version 2>&1) | sed 's/referenceseeker //' )
    END_VERSIONS
    """
}
