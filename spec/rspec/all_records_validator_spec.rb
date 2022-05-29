# frozen_string_literal: true

RSpec.describe RSpec::AllRecordsValidator do
  after do
    Foo.delete_all
    Bar.delete_all
  end

  context 'With golden path' do
    before do
      Foo.create
      Bar.create
    end

    it 'All Records are valid' do
      expect { RSpec::AllRecordsValidator.validate! }.not_to raise_error
    end
  end

  context 'With invalid data' do
    context 'With invalid non-abstract record' do
      before do
        foo = Foo.new(name: 'n'*11)
        foo.save(validate: false)
        Bar.create
      end

      it 'One record is invalid' do
        expect { RSpec::AllRecordsValidator.validate! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'With invalid abstract record' do
      before do
        bar = Bar.new(name: 'n'*11)
        bar.save(validate: false)
        Bar.abstract_class = true
      end

      it 'It ignores an abstract class records' do
        expect { RSpec::AllRecordsValidator.validate! }.not_to raise_error
      end
    end

    context 'With invalid non-has_many model records' do
      before do
        baz = Baz.new(name: 'n'*11)
        baz.save(validate: false)
      end

      it 'It ignores  model records' do
        expect { RSpec::AllRecordsValidator.validate! }.not_to raise_error
      end
    end
  end
end
