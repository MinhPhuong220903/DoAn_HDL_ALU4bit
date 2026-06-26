library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alu4 is
end tb_alu4;

architecture test of tb_alu4 is

    signal A     : STD_LOGIC_VECTOR(3 downto 0);
    signal B     : STD_LOGIC_VECTOR(3 downto 0);
    signal sel   : STD_LOGIC_VECTOR(2 downto 0);
    signal Y     : STD_LOGIC_VECTOR(3 downto 0);
    signal carry : STD_LOGIC;
    signal zero  : STD_LOGIC;

begin

    uut: entity work.alu4
        port map (
            A     => A,
            B     => B,
            sel   => sel,
            Y     => Y,
            carry => carry,
            zero  => zero
        );

    process
    begin
        A <= "0101";
        B <= "0011";

        sel <= "000"; wait for 10 ns; -- A + B
        sel <= "001"; wait for 10 ns; -- A - B
        sel <= "010"; wait for 10 ns; -- A AND B
        sel <= "011"; wait for 10 ns; -- A OR B
        sel <= "100"; wait for 10 ns; -- A XOR B
        sel <= "101"; wait for 10 ns; -- NOT A
        sel <= "110"; wait for 10 ns; -- A > B
        sel <= "111"; wait for 10 ns; -- Y = A

        A <= "0001";
        B <= "0001";
        sel <= "001"; wait for 10 ns; -- zero = 1

        A <= "1111";
        B <= "0001";
        sel <= "000"; wait for 10 ns; -- carry = 1

        wait;
    end process;

end test;
