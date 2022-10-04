 include { NCBIGENOMEDOWNLOAD } from './modules/nf-core/modules/ncbigenomedownload/main'
 include { REFERENCESEEKER_DB } from './modules/local/referenceseeker/db'

 workflow {
    organism_list = params.organisms?.tokenize(',')
    organisms = Channel.from(organism_list)
    NCBIGENOMEDOWNLOAD(organisms)
    seq_ch = NCBIGENOMEDOWNLOAD.out.fna.join(NCBIGENOMEDOWNLOAD.out.metadata)
    REFERENCESEEKER_DB(seq_ch)
 }