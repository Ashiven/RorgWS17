#RUN := -all
#LIB := work
#VSIM := vsim -novopt
#VCOM := vcom
VMAP := RorgPrSimLib:../../../tools/ROrgPrSimLib
REMOTE_DIR := ~/.RorgPrRemote/

export PATH := ../../../tools/:$(PATH)

COMPILE  := adder_1bit.vhd alu_1bit.vhd alu_1bit_tb.vhd
SIMULATE := alu_1bit_tb

all: vsim/$(SIMULATE)
	ln -fs vsim/$(SIMULATE).vcd.gz waveform.vcd.gz
	ln -fs vsim/$(SIMULATE)        transcript

<<<<<<< HEAD
=======
vsim/$(SIMULATE): | $(foreach FILE,$(COMPILE),vcom/$(FILE))

>>>>>>> eb70c4bc105bacb5b47e4c0ac7ce6d5bdc3e8f32
define RULE
vcom/$(1): $(wildcard $(1))
endef

$(foreach FILE,$(COMPILE),$(eval $(call RULE,$(FILE))))

.PHONY:
view:
wave:
view_wave:
	gtkwave -mtranscript waveform.vcd.gz

.PHONY:
clean:
	rm -f waveform.vcd.gz
	rm -f transcript

-include ../../../tools/modelsim.mk
-include ../../../tools/remote.mk
