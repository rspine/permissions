require 'spine/permissions'

module Spine
  module Permissions
    describe Collection do
      it 'denies by deafult' do
        expect(subject.granted?(:read, :data)).to be false
        expect(subject.denied?(:read, :data)).to be true
      end

      it 'grants permission' do
        subject.grant(:read, :data)
        expect(subject.granted?(:read, :data)).to be true
        expect(subject.denied?(:read, :data)).to be false
      end

      it 'denies permission' do
        subject.deny(:read, :data)
        expect(subject.granted?(:read, :data)).to be false
        expect(subject.denied?(:read, :data)).to be true
      end

      describe 'when registering' do
        it 'registers grant permission' do
          subject.grant(:read, :data)
          expect(subject.permission(:read, :data)).to be Grant
        end

        it 'registers deny permission' do
          subject.deny(:read, :data)
          expect(subject.permission(:read, :data)).to be Deny
        end

        it 'overrides specific action on specific resource' do
          subject.grant(:read, :data).deny(:read, :data)
          expect(subject.granted?(:read, :data)).to be false
        end

        it 'overrides specific action on all resources' do
          subject.grant(:read, :data).deny(:read, :all)
          expect(subject.granted?(:read, :data)).to be false
        end

        it 'overrides all actions on specific resources' do
          subject.grant(:read, :data).deny(:all, :data)
          expect(subject.granted?(:read, :data)).to be false
        end

        it 'overrides all actions on all resources' do
          subject.grant(:read, :data).deny(:all, :all)
          expect(subject.granted?(:read, :data)).to be false
        end
      end
    end
  end
end
