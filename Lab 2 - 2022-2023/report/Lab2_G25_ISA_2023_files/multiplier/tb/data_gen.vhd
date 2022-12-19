library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity data_gen is  
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    D0    : out std_logic_vector(31 downto 0);
    D1    : out std_logic_vector(31 downto 0);
    D2    : out std_logic_vector(31 downto 0);
    RDY   : in std_logic;
    VOUT  : out std_logic;
    END_SIM : out std_logic);
end entity data_gen;

architecture beh of data_gen is

  constant tco : time := 1 ns;

  type tval_t is array (0 to 9) of std_logic_vector(31 downto 0);
  constant ctvalA : tval_t := (
    ('0' & conv_std_logic_vector(127+5, 8) & conv_std_logic_vector(6, 3) & conv_std_logic_vector(0, 23-3)),  --376
    ('0' & conv_std_logic_vector(127+9, 8) & conv_std_logic_vector(11, 5) & conv_std_logic_vector(0, 23-5)),  --64
    ('0' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(0, 23)),  --1792.02
    ('1' & conv_std_logic_vector(127+3, 8) & conv_std_logic_vector(7, 3) & conv_std_logic_vector(0, 23-3)),  -- -15
    ('1' & conv_std_logic_vector(127+7, 8) & conv_std_logic_vector(19, 5) & conv_std_logic_vector(0, 23-5)),  -- -204
    ('1' & conv_std_logic_vector(127+10, 8) & conv_std_logic_vector(0, 23)),  -- -1024
	-- extending the tb to 10 results
    ('0' & conv_std_logic_vector(127+4, 8) & conv_std_logic_vector(6, 3) & conv_std_logic_vector(0, 23-3)),  -- -26
    ('1' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(7, 3) & conv_std_logic_vector(0, 23-3)),  -- 52
    ('1' & conv_std_logic_vector(127+1, 8) & conv_std_logic_vector(7, 3) & conv_std_logic_vector(0, 23-3)),  -- -3.75
    ('0' & conv_std_logic_vector(127+2, 8) & conv_std_logic_vector(5, 3) & conv_std_logic_vector(0, 23-3))  -- -24
    );  

  constant ctvalB : tval_t := (
    ('0' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(15, 5) & conv_std_logic_vector(1, 23-5)),  --56
    ('0' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(0, 23)),  --688
    ('1' & conv_std_logic_vector(127+10, 8) & conv_std_logic_vector(6, 3) & conv_std_logic_vector(124, 23-3)),  -- -64
    ('1' & conv_std_logic_vector(127+7, 8) & conv_std_logic_vector(19, 5) & conv_std_logic_vector(0, 23-5)),  -- -204
    ('1' & conv_std_logic_vector(127+10, 8) & conv_std_logic_vector(0, 23)),   -- -1024
    ('0' & conv_std_logic_vector(127+3, 8) & conv_std_logic_vector(7, 3) & conv_std_logic_vector(0, 23-3)),   --15    
	-- extending the tb to 10 results
    ('1' & conv_std_logic_vector(127+4, 8) & conv_std_logic_vector(5, 3) & conv_std_logic_vector(0, 23-3)),  -- -28
    ('0' & conv_std_logic_vector(127+5, 8) & conv_std_logic_vector(5, 3) & conv_std_logic_vector(0, 23-3)),  -- -120
    ('1' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(6, 3) & conv_std_logic_vector(0, 23-3)),  -- -112
    ('1' & conv_std_logic_vector(127+4, 8) & conv_std_logic_vector(4, 3) & conv_std_logic_vector(0, 23-3))  -- 6.5
    );  
  
  signal cnt : integer := 0;
  signal sEnd_sim : std_logic;

  signal sEnd_sim_pipe : std_logic_vector(5 downto 0);
  
begin  -- architecture beh

  process (CLK, RST_n) is
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      cnt <= 0;  
      D0 <= (others => '0');
      D1 <= (others => '0');
      D2 <= (others => '0');
      VOUT <= '0';
      sEnd_sim <= '0';
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if (cnt < 10 ) then
        cnt <= cnt + 1 after tco;
        D0 <= ctvalA(cnt) after tco;
        D1 <= ctvalB(cnt) after tco;
        VOUT <= '1' after tco;
        sEnd_sim <= '0' after tco;          
      else
        VOUT <= '0' after tco;
        sEnd_sim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n) is
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      sEnd_sim_pipe <= (others => '0');
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      sEnd_sim_pipe(0) <= sEnd_sim after tco;
      sEnd_sim_pipe(5 downto 1) <= sEnd_sim_pipe(4 downto 0) after tco;
    end if;
  end process;

  END_SIM <= sEnd_sim_pipe(5);

end beh;
