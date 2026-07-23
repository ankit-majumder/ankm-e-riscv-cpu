# ANKM-E CPU ISA Design Documentation

|Registers | Use |
|------------|---|
|x0|hardcoded 0|
|x1|Link Register|
|x2|Stack Pointer|
|x3, x4|General Purpose|
|x5|Alternate Link Register|
|x6-x31|General Purpose|
|pc|Program Counter / Instruction Pointer|

For the purpose of this project, all instructions will be 32 bit aligned in practice, but will be implemented as 16 bit aligned

Instruction Types:
- R: Register-Register operations
- I: Register-Immediate operations
- S: Store Operations
- B: Conditonal (Branch) Operations
- U: Upper Immediate Operations
- J: Jump (Unconditional Branch) Operations


Notes: 
1. Memory is Byte Addressable Little Endian, with 32 bit address space
2. Instructions are 2 Byte Aligned Little Endian Packets.
3. Memory Accesses must be 4-byte aligned for lw and 2-byte aligned for lh, in practice
3. B and J Instructions are the same as S and U instructions respectively, but implicitly shift immediate values right by 1, since instructions are 2 byte aligned in the instruction compression extension (however, for this processor they will 4 byte aligned in practice)
4. All immediates are sign extended
5. In practice, JALR rs1 will be x1 (Link Register), imm will be 0, and rd can be x0 (discard function pc) or general purpose (store function pc)
6. JALR clears the bit 0 of the pc to force function return to be 2-byte aligned
7. fence, ecall/ebreak, and csr instructions are stubbed and implemented as NOP, as they will not be called on a single cycle bare metal cpu with no operating system
8. For ecall and ebreak encoding, the funct7 columns are the hardcoded values of the immediates, not actual funct7 values.
9. All loads are sign extended, and all immediates are treated as signed values unless otherwise specified
10. Despite 32 bit address space, only 1024 Bytes of memory are actually mapped, from location 0x0 to location 0x3FF due to student project limitations.

Instruction Formats:  
[a:b] represents bits a to b  
R: [31:25 => funct7][24:20 => rs2][19:15 => rs1][14:12 => funct3][11:7 => rd][6:0 => opcode]    
I: [31:20 => imm[11:0]][19:15 => rs1][14:12 => funct3][11:7 => rd][6:0 => opcode]   
S: [31:25 => imm[11:5]][24:20 => rs2][19:15 => rs1][14:12 => funct3][11:7 => imm[4:0]][6:0 => opcode]    
B: [31 => imm[12](sign bit)][30:25 => imm[10:5]][24:20 => rs2][19:15 => rs1][14:12 => funct3][11:8 => imm[4:1]][7 => imm[11]][6:0 => opcode]  
U: [31:12 => (imm[19:0]<<12)][11:7 => rd][6:0 => opcode]  
J: [31 => imm[20](sign bit)][30:21 => imm[10:1]][20 => imm[11]][19:12 => imm[19:12]][11:7 => rd][6:0 => opcode] 

# R-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|-----------|----|--------|-----|------|------------|-------|
|add|R-Type|000|0000000|0110011|add rd, rs1, rs2|rd=rs1+rs2|
|sub|R-Type|000|0100000|0110011|sub rd, rs1, rs2|rd=rs1-rs2|
|sll|R-Type|001|0000000|0110011|sll rd, rs1, rs2|rd=rs1<<rs2|
|slt|R-Type|010|0000000|0110011|slt rd, rs1, rs2|rs1<rs2?rd=1:rd=0, signed comparison|
|sltu|R-Type|011|0000000|0110011|sltu rd, rs1, rs2|rs1<rs2?rd=1:rd=0, unsigned comparison|
|xor|R-Type|100|0000000|0110011|xor rd, rs1, rs2|rd=rs1^rs2|
|srl|R-Type|101|0000000|0110011|srl rd, rs1, rs2|rd=rs1>>rs2, sign bit discarded|
|sra|R-Type|101|0100000|0110011|sra rd, rs1, rs2|rd=rs1>>rs2, sign bit retained|
|or|R-Type|110|0000000|0110011|or rd, rs1, rs2|rd=rs1 OR rs2|
|and|R-Type|111|0000000|0110011|and rd, rs1, rs2|rd=rs1&rs2|

# I-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|---|-----|---|---|----|---|-----|
|lb|I-Type|000|-------|0000011|lb rd, imm(rs1)|rd loaded with byte value at M[rs1 + imm]|
|lh|I-Type|001|-------|0000011|lh rd, imm(rs1)|rd loaded with half-word value at M[rs1 + imm]
|lw|I-Type|010|-------|0000011|lw rd, imm(rs1)|rd loaded with word value at M[rs1+imm]|
|lbu|I-Type|100|-------|0000011|lbu rd, imm(rs1)|rd loaded with byte value at M[rs1 + imm], non-sign extended|
|lhu|I-Type|101|-------|0000011|lhu rd, imm(rs1)|rd loaded with half-word value at M[rs1 + imm], non-sign extended|
|fence|I-Type|000|-------|0001111|---------|Stubbed (Implemented as NOP)|
|fence.i|I-Type|001|-------|0001111|-------|Stubbed (Implemented as NOP)
|addi|I-Type|000|-------|0010011|addi rd, rs1, imm|rd=rs1+imm|
|slli|I-Type|001|0000000|0010011|slli rd, rs1, imm|rd=rs1<<imm|
|slti|I-Type|010|-------|0010011|slti rd, rs1, imm|rs1<imm?rd=1:rd=0, sign extended|
|sltiu|I-Type|011|-------|0010011|sltiu rd, rs1, imm|rs1<imm?rd=1:rd=0, non sign extended|
|xori|I-Type|100|-------|0010011|xori rd, rs1, imm|rd=rs1^imm|
|srli|I-Type|101|0000000|0010011|srli rd, rs1, imm|rd=rs1>>imm, sign bit discarded|
|srai|I-Type|101|0100000|0010011|srai rd, rs1, imm|rd=rs1>>imm, sign bit retained|
|ori|I-Type|110|-------|0010011|ori rd, rs1, imm|rd = rs1 OR imm|
|andi|I-Type|111|-------|0010011|andi rd, rs1, imm|rd=rs1&imm|
|jalr|I-Type|000|-------|1100111|jalr rd, rs1, imm|rd=pc+4, pc=(rs1+imm)& ~(0x01)
|ecall|I-Type|000|000000000001|1110011|--------|Stubbed (Implemented as NOP)
|ebreak|I-Type|000|000000000001|1110011|-------|Stubbed (Implemented as NOP)
|csrrw|I-Type|001|-------|1110011|-------|Stubbed (rd = 0)
|csrrs|I-Type|010|-------|1110011|-------|Stubbed (rd = 0)
|csrrc|I-Type|011|-------|1110011|-------|Stubbed (rd = 0)
|csrrwi|I-Type|101|-------|1110011|-------|Stubbed (rd = 0)
|csrrsi|I-Type|110|-------|1110011|-------|Stubbed (rd = 0)
|csrrci|I-Type|111|-------|1110011|-------|Stubbed (rd = 0)

# S-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|---|-----|---|---|----|---|-----|
|sb|S-Type|000|-------|0100011|sb rs2, imm(rs1)|store rs2 lowest byte at M[rs1 + imm]
|sh|S-Type|001|-------|0100011|sh rs2, imm(rs1)|store rs2 lowest half-word at M[rs1 + imm]
|sw|S-Type|010|-------|0100011|sw rs2, imm(rs1)|store rs2 at M[rs1 + imm]

# B-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|---|-----|---|---|----|---|-----|
|beq|B-Type|000|-------|1100011|beq rs1, rs2, imm|rs1==rs2?pc=pc+imm:pc=pc+4 
|bne|B-Type|001|-------|1100011|bne rs1, rs2, imm|rs1!=rs2?pc=pc+imm:pc=pc+4
|blt|B-Type|100|-------|1100011|blt rs1, rs2, imm|rs1<rs2?pc=pc+imm:pc=pc+4, signed comparison
|bge|B-Type|101|-------|1100011|bge rs1, rs2, imm|rs1>=rs2?pc=pc+imm:pc=pc+4, signed comparison
|bltu|B-Type|110|-------|1100011|bltu rs1, rs2, imm|rs1<rs2?pc=pc+imm:pc=pc+4, unsigned comparison
|bgeu|B-Type|111|-------|1100011|bgeu rs1, rs2, imm|rs1>=rs2?pc=pc+imm:pc=pc+4, unsigned comparison

# U-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|---|-----|---|---|----|---|-----|
|lui|U-Type|---|-------|0110111|lui rd, imm|loads top 20 bits of rd with imm value
|auipc|U-Type|---|-------|0010111|auipc rd, imm|rd=PC+(imm<<12)

# J-Type Instructions
|Instruction|Type|funct3|funct7|opcode|Syntax|Description|
|---|-----|---|---|----|---|-----|
|jal|J-Type|---|-------|1101111|jal rd, imm|rd=pc+4, pc=pc+imm

