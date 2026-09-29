library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_dff_sync_reset is
-- Testbench tidak memiliki port I/O
end tb_dff_sync_reset;

architecture Behavior of tb_dff_sync_reset is
    component dff_sync_reset
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            d   : in  STD_LOGIC;
            q   : out STD_LOGIC
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal d   : STD_LOGIC := '0';
    signal q   : STD_LOGIC;

    constant clk_period : time := 20 ns;

begin
    -- Instantiate UUT
    uut: dff_sync_reset Port Map (
        clk => clk,
        rst => rst,
        d   => d,
        q   => q
    );

    -- Clock Generator (20 ns period)
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Inisialisasi & Reset
        rst <= '1';
        wait for 40 ns;
        
        rst <= '0';
        d <= '1';
        wait for 30 ns;
        
        d <= '0';
        wait for 20 ns;
        
        -- Uji reset saat d='1'
        d <= '1';
        wait for 15 ns;
        rst <= '1';
        wait for 20 ns;
        
        rst <= '0';
        wait;
    end process;
end Behavior;