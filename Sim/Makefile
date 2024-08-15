##################################################################################################
#This file created by Huy Nguyen
#Created date: 7/1/2019
##################################################################################################

#Define variables
TESTNAME 	    ?= 
TB_NAME 	    ?= test_bench
RADIX		      ?= hexadecimal
#================================================================================================

all: build run

build:
	mkdir -p log
	rm -rf run_test.v 
	touch run_test.v
	vlib work
	vmap work work
	vlog -f compile.f

run:	
	ln -sf ../testcases/$(TESTNAME).v run_test.v
	vlog -f compile.f
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -assertdebug -c $(TB_NAME) -do "log -r /*;run -all;"
	mv $(TESTNAME).log ./log
	cp -rf  vsim.wlf $(TESTNAME).wlf
	mv $(TESTNAME).wlf ./log
	ln -sf ./log/$(TESTNAME).log sim.log

wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$(RADIX)" &

run_cov:
	ln -sf ../testcases/$(TESTNAME).v run_test.v
	vlog +cover=sbceftx -f compile.f
	vsim -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover=bcesfx" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r -d 6 /*;run -all"
	mv $(TESTNAME).log ./log

gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -file coverage/summary_report.txt
	vcover report -zeros -details -code bcefsx -All -codeAll IP.ucdb -file coverage/detail_report.txt

clean:
	rm -rf work
	rm -rf vsim.dbg
	rm -rf log
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf transcript
	rm -rf coverage
	rm -rf *.ucdb
	rm -rf *.v

help:
	@echo "Use command: make {option} {argument}" 
	@echo "{option} is:" 
	@echo "build            :Compile rtl and testbench" 
	@echo "run              :Run simulation" 
	@echo "all              :Compile and run simulation" 
	@echo "wave             :Loading waveform" 
	@echo "run_cov          :Run single test with coverage" 
	@echo "gen_cov          :Generate coverage report" 
	@echo "clean            :Clean up environment" 
	@echo "{argument} is: TESTNAME" 
	@echo "Example:" 
	@echo "make run TESTNAME=default_register_test" 

