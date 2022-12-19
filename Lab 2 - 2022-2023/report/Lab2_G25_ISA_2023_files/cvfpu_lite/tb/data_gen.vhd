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
    ('0' & conv_std_logic_vector(127+7, 8) & conv_std_logic_vector(123, 7) & conv_std_logic_vector(0, 23-7)),  --251
    ('0' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(3, 2) & conv_std_logic_vector(0, 23-2)),  --112
    ('0' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(9, 6) & conv_std_logic_vector(0, 23-6)),  --73
    ('0' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(85, 8) & conv_std_logic_vector(0, 23-8)),  --341
    ('0' & conv_std_logic_vector(127+4, 8) & conv_std_logic_vector(3, 4) & conv_std_logic_vector(0, 23-4)),  --19
    ('1' & conv_std_logic_vector(127+4, 8) & conv_std_logic_vector(1, 1) & conv_std_logic_vector(0, 23-1)),  --(-24)
    ('1' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(61, 6) & conv_std_logic_vector(0, 23-6)),  --(-125)
    ('1' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(3, 5) & conv_std_logic_vector(0, 23-5)),  --(-70)
    ('1' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(63, 8) & conv_std_logic_vector(0, 23-8)),  --(-319)
    ('1' & conv_std_logic_vector(127+7, 8) & conv_std_logic_vector(9, 4) & conv_std_logic_vector(0, 23-4))  --(-200)
    );

  constant ctvalB : tval_t := (
    ('0' & conv_std_logic_vector(127+6, 8) & conv_std_logic_vector(15, 4) & conv_std_logic_vector(0, 23-4)),  --124
    ('0' & conv_std_logic_vector(127+5, 8) & conv_std_logic_vector(25, 5) & conv_std_logic_vector(0, 23-5)),  --57
    ('0' & conv_std_logic_vector(127+9, 8) & conv_std_logic_vector(95, 8) & conv_std_logic_vector(0, 23-8)),  --702
    ('0' & conv_std_logic_vector(127+9, 8) & conv_std_logic_vector(77, 9) & conv_std_logic_vector(0, 23-9)),  --589
    ('0' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(53, 8) & conv_std_logic_vector(0, 23-8)),  --309
    ('1' & conv_std_logic_vector(127+5, 8) & conv_std_logic_vector(29, 5) & conv_std_logic_vector(0, 23-5)),  --(-61)
    ('1' & conv_std_logic_vector(127+7, 8) & conv_std_logic_vector(21, 7) & conv_std_logic_vector(0, 23-7)),  --(-149)
    ('1' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(33, 8) & conv_std_logic_vector(0, 23-8)),  --(-289)
    ('1' & conv_std_logic_vector(127+8, 8) & conv_std_logic_vector(185, 8) & conv_std_logic_vector(0, 23-8)),  --(-441)
    ('1' & conv_std_logic_vector(127+9, 8) & conv_std_logic_vector(71, 8) & conv_std_logic_vector(0, 23-8))  --(-654)
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
      if (cnt < 10) then
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

