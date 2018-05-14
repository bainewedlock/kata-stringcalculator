require 'rspec'
require_relative 'calc'

describe 'add' do
  it 'returns 0 for empty string' do
    expect(add '').to eq 0
  end
  it 'converts single number to int' do
    expect(add '1').to eq 1
  end
  it 'adds two comma separated numbers' do
    expect(add '1,2').to eq 3
  end
  it 'treats comma and new line as separator' do
    expect(add "1\n2,3").to eq 6
  end
  it 'supports custom delimiter' do
    expect(add "//;\n1;2").to eq 3
    expect(add "//;\n2;2").to eq 4
    expect(add "//!!\n2!!2").to eq 4
  end
  it 'rejects negative numbers' do
    expect{add "-1"}.to raise_error "negatives not allowed: -1"
    expect{add "5, -3, 2, -9"}.to raise_error "negatives not allowed: -3, -9"
  end
  it 'ignores numbers bigger than 1000' do
    expect(add "2,1001").to eq 2
  end
  it 'ignores square brackets around delimiter' do
    expect(add "//[***]\n1***2***3").to eq 6
  end
  it 'allowes multiple delimiters' do
    expect(add "//[*][%]\n1*2%3").to eq 6
  end
end
