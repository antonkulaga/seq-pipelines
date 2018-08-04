workflow validation_pipeline {
        File truth_vcf
        File query_vcf
        File bed
        File prefix

        call vcf_evaluation {
                input:
                        truth_vcf = truth_vcf,
                        query_vcf = query_vcf,
                        bed = bed
                        prefix = prefix
        }

}

task vcf_evaluation {

        File truth_vcf
        File query_vcf
        File bed
        String prefix

        command {
        /opt/hap.py/bin/hap.py ${truth_vcf} \
        ${query_vcf} \
        -f ${bed} \
        -o ${prefix}
        }

        runtime {
        docker: "pkrusche/hap.py"
        }

        output {
        File file1 = prefix + metrics.json
        File file2 = prefix + summary.csv
        }
}

