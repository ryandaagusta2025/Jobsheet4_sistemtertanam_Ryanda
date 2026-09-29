library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_reg8_en is
    Port (
        clk  : in  STD_LOGIC;                    -- Clock 100 MHz (W5)
        btnU : in  STD_LOGIC;                    -- Reset (Button Up)
        btnC : in  STD_LOGIC;                    -- Enable (Button Center)
        sw   : in  STD_LOGIC_VECTOR(7 downto 0); -- Input Data
        led  : out STD_LOGIC_VECTOR(7 downto 0)  -- Output Register
    );
end top_reg8_en;

architecture Behavioral of top_reg8_en is
    component reg8_en
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            en  : in  STD_LOGIC;
            d   : in  STD_LOGIC_VECTOR(7 downto 0);
            q   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
begin
    u_reg8: reg8_en
        port map (
            clk => clk,
            rst => btnU,
            en  => btnC,
            d   => sw,
            q   => led
        );
end Behavioral;