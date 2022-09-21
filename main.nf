// Declare syntax version
nextflow.enable.dsl=2

// Script parameters
params.input_dir

process bcl2fastq {
  publishDir "${params.output_dir}", mode: 'copy', overwrite: true

  input:
    val command_string

  output:
    file "*.fastq.gz"
    file "Reports"
    file "Stats"

    """
    ${command_string}
    """
}

workflow {
   def input_ch = Channel.fromPath(params.command_string)
   bcl2fastq(input_ch)
}

