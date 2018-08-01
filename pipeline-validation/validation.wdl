workflow validation_pipeline {
	File truth_vcf
	File query_vcf
	File bed

	call vcf_evaluation {
		input:
			truth_vcf = truth_vcf
			query_vcf = query_vcf
			bed = bed			
	}
	
	output {
		File out = vcf_evaluation.out
	}
}

task vcf_evaluation {

	File truth_vcf
	File query_vcf
        File bed
	
	command {	
	opt/hap.py/bin/hap.py truth_vcf \
	query_vcf \
	-f bed \
	-o test
	}

	runtime {
	docker "pkrusche/hap.py"
	}

	output {
	File out = "test"
	}
}

