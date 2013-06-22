require 'spec_helper'

describe SensorsHelper, type: :helper do
  describe '#data_point_cleanup' do
  	it "returns congruent data_points if array 1 > array 2" do
  		dataset = [
  				[[1,'a'],[2,'b'],[3,'c']],
  				[[1,'a'],[3,'c']]
  		]
  		cleaned_dataset = cleanup_dataset dataset
  		cleaned_dataset[0].length.should eq(2)
  	end

  	it "returns congruent data_points if array 2 > array 1" do
  		dataset = [
  				[[1,'a'],[2,'b']],
  				[[1,'a'],[2,'b'],[3,'c']]
  		]
  		cleaned_dataset = cleanup_dataset dataset
  		cleaned_dataset[1].length.should eq(2)
  	end

	end
end