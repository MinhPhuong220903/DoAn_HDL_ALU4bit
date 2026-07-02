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

    -- Ham chuyen STD_LOGIC_VECTOR sang chuoi nhi phan
    function slv_to_string(slv : STD_LOGIC_VECTOR) return string is
        variable result : string(1 to slv'length);
        variable j      : integer := 1;
    begin
        for i in slv'range loop
            case slv(i) is
                when '0' => result(j) := '0';
                when '1' => result(j) := '1';
                when others => result(j) := 'X';
            end case;
            j := j + 1;
        end loop;
        return result;
    end function;

    -- Ham chuyen STD_LOGIC sang chuoi
    function sl_to_string(s : STD_LOGIC) return string is
    begin
        case s is
            when '0' => return "0";
            when '1' => return "1";
            when others => return "X";
        end case;
    end function;

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
        -- Thu tuc in ket qua ra Log
        procedure print_result is
        begin
            report time'image(now) & "    " &
                   slv_to_string(A) & "    " &
                   slv_to_string(B) & "    " &
                   slv_to_string(sel) & "    " &
                   slv_to_string(Y) & "    " &
                   sl_to_string(carry) & "        " &
                   sl_to_string(zero);
        end procedure;

    begin
        report "Time      A       B       sel     Y       carry    zero";

        A <= "0101";
        B <= "0011";

        sel <= "000";
        wait for 10 ns;
        print_result;
        assert Y = "1000" and carry = '0' and zero = '0'
        report "Test ADD failed" severity error;

        sel <= "001";
        wait for 10 ns;
        print_result;
        assert Y = "0010" and carry = '0' and zero = '0'
        report "Test SUB failed" severity error;

        sel <= "010";
        wait for 10 ns;
        print_result;
        assert Y = "0001" and carry = '0' and zero = '0'
        report "Test AND failed" severity error;

        sel <= "011";
        wait for 10 ns;
        print_result;
        assert Y = "0111" and carry = '0' and zero = '0'
        report "Test OR failed" severity error;

        sel <= "100";
        wait for 10 ns;
        print_result;
        assert Y = "0110" and carry = '0' and zero = '0'
        report "Test XOR failed" severity error;

        sel <= "101";
        wait for 10 ns;
        print_result;
        assert Y = "1010" and carry = '0' and zero = '0'
        report "Test NOT A failed" severity error;

        sel <= "110";
        wait for 10 ns;
        print_result;
        assert Y = "0001" and carry = '0' and zero = '0'
        report "Test A > B failed" severity error;

        sel <= "111";
        wait for 10 ns;
        print_result;
        assert Y = "0101" and carry = '0' and zero = '0'
        report "Test PASS A failed" severity error;

        A <= "0001";
        B <= "0001";
        sel <= "001";
        wait for 10 ns;
        print_result;
        assert Y = "0000" and zero = '1'
        report "Test ZERO failed" severity error;

        A <= "1111";
        B <= "0001";
        sel <= "000";
        wait for 10 ns;
        print_result;
        assert Y = "0000" and carry = '1' and zero = '1'
        report "Test CARRY failed" severity error;

        report "All ALU4 VHDL tests completed successfully";

        wait;
    end process;

end test;
