import os
import random 
import cocotb 
from cocotb.triggers import Timer 
import cocotb_test.simulator

@cocotb.test()
async def test_create_clock(dut):
    for _ in range(10):
        clock = dut.i_clk_100MHz.value
        #clock = dut.i_clk_100MHz
        clock <= 1
        await Timer(5,units='ns')
        clock <= 0
        await Timer(5,units='ns')
        #dut.i_clk_100MHz = clock 

def test_full_adder():
    src_file = os.path.join(os.path.dirname(__file__), "..", "src", "JohnsonCounter.vhd")
    cocotb_test.simulator.run(
        vhdl_sources=[src_file],
        toplevel="johnsoncounter",
        module="test_dut",  
        simulator="ghdl"
    )
## run  pytest -v test_dut.py