library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_piso_shift_reg is
    Port (
        clk  : in  STD_LOGIC;                    -- Clock 100 MHz (pin W5)
        btnU : in  STD_LOGIC;                    -- Reset (Button Up)
        btnC : in  STD_LOGIC;                    -- Load Data (Button Center)
        sw   : in  STD_LOGIC_VECTOR(7 downto 0); -- Data Input 8-bit dari Sakelar
        led0 : out STD_LOGIC                     -- Serial Output Data (sout) ke LED 0
    );
end top_piso_shift_reg;

architecture Behavioral of top_piso_shift_reg is
    signal sync_rst  : STD_LOGIC;
    signal sync_load : STD_LOGIC;
    
    -- Register internal 8-bit
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    -- Memanggil modul synchronizer 2-stage dari tugas sebelumnya
    component synchronizer_2ff
        Port (
            clk      : in  STD_LOGIC;
            async_in : in  STD_LOGIC;
            sync_out : out STD_LOGIC
        );
    end component;

begin
    -- Synchronizer untuk Reset (btnU)
    sync_reset_inst : synchronizer_2ff
        port map (
            clk      => clk,
            async_in => btnU,
            sync_out => sync_rst
        );

    -- Synchronizer untuk Load (btnC)
    sync_load_inst : synchronizer_2ff
        port map (
            clk      => clk,
            async_in => btnC,
            sync_out => sync_load
        );

    -- Logika PISO (Parallel-In Serial-Out)
    process(clk)
    begin
        if rising_edge(clk) then
            if sync_rst = '1' then
                shift_reg <= (others => '0');
            elsif sync_load = '1' then
                shift_reg <= sw; -- Memuat data paralel 8-bit dari sakelar
            else
                -- Pada setiap tepi clock, data digeser ke kiri (MSB keluar lebih dulu)
                shift_reg <= shift_reg(6 downto 0) & '0';
            end if;
        end if;
    end process;

    -- Bit MSB (paling kiri) dikeluarkan secara serial ke LED 0
    led0 <= shift_reg(7);

end Behavioral;