library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_sync_toggle is
    Port (
        clk  : in  STD_LOGIC;
        btnC : in  STD_LOGIC;  -- Input tombol asinkron
        led0 : out STD_LOGIC   -- Output LED(0)
    );
end top_sync_toggle;

architecture Behavioral of top_sync_toggle is
    signal sync_btn : STD_LOGIC := '0';
    signal btn_prev : STD_LOGIC := '0';
    signal toggle   : STD_LOGIC := '0';

    component synchronizer_2ff
        Port (
            clk      : in  STD_LOGIC;
            async_in : in  STD_LOGIC;
            sync_out : out STD_LOGIC
        );
    end component;
begin
    -- Instansiasi Synchronizer 2-Tingkat
    u_sync : synchronizer_2ff
        port map (
            clk      => clk,
            async_in => btnC,
            sync_out => sync_btn
        );

    -- Edge Detector & Toggle Logic
    process(clk)
    begin
        if rising_edge(clk) then
            btn_prev <= sync_btn;
            
            -- Deteksi Rising Edge (transisi dari '0' ke '1')
            if sync_btn = '1' and btn_prev = '0' then
                toggle <= not toggle;
            end if;
        end if;
    end process;

    led0 <= toggle;
end Behavioral;