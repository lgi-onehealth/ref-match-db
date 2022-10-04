.PHONY: clean

clean:
	rm -rf .nextflow* work databases

run:
	nextflow run main.nf -profile conda -resume

test:
	mkdir -p testing; \
	tmp=testing; \
	cd $$tmp; \
	nextflow run lgi-onehealth/ref-match-db -profile test,conda -latest; \
	cd -; \
	rm -rf $$tmp
