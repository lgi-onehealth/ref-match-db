.PHONY: clean

clean:
	rm -rf .nextflow* work databases

run:
	nextflow run main.nf -profile conda -resume 