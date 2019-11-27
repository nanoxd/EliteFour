test: test_core test_advent

test_advent:
	cd Advent && swift test 2>&1 | xcpretty

test_core:
	cd EliteCore && swift test 2>&1 | xcpretty
