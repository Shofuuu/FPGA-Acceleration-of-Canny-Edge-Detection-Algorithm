library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;

entity ip_address_generator_crow is
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    --size      : in  std_logic_vector(C_MEM_ADDR_WIDTH downto 0);	
    add_out   : out std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
    vld_out   : out std_logic);    
end ip_address_generator_crow;

architecture address of ip_address_generator_crow is
signal increment : std_logic_vector(C_MEM_ADDR_WIDTH downto 0) := (0 => '1', others => '0');
begin
  process(clk, rst)
  variable gen_addr : std_logic_vector(C_MEM_ADDR_WIDTH downto 0) := std_logic_vector(to_unsigned(C_COLUMN_COUNT, C_MEM_ADDR_WIDTH+1));
  variable size_count : std_logic_vector(C_MEM_ADDR_WIDTH downto 0);
    begin
      size_count := std_logic_vector(to_unsigned(C_TOTAL_GROUPS+C_COLUMN_COUNT, C_MEM_ADDR_WIDTH+1));
      if rst = '1' then
        add_out <= (others => '0');
		gen_addr := gen_addr;
        vld_out <= '0';
      elsif rising_edge(clk) then
	    if en = '1' then
     	  gen_addr := std_logic_vector(unsigned(gen_addr) + unsigned(increment));
          if gen_addr <= size_count then
            add_out <= gen_addr(C_MEM_ADDR_WIDTH-1 downto 0);  
            vld_out <= '1';
          else
            vld_out <= '0';
          end if;
        else 
          add_out <= (others => '0');
          gen_addr := gen_addr;
		  vld_out <= '0';		  
        end if;  
      end if;
    end process;	  
end address;
