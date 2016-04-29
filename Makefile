
zip: projet_prostoch.zip
projet_prostoch.zip: .FORCE
	git archive master --format zip -o projet_prostoch.zip
.PHONY: zip

.FORCE:

