#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2014 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require File.expand_path('../../../../spec_helper', __FILE__)

describe Api::V3::RolesController do
  let(:current_user) { FactoryGirl.create(:admin) }

  before do
    allow(User).to receive(:current).and_return(current_user)
  end

  describe '#index' do
    context 'with no roles available' do
      it 'assigns an empty roles array' do
        get 'index', format: 'xml'
        expect(assigns(:roles)).to eq []
      end

      it 'renders the index template' do
        get 'index', format: 'xml'
        expect(response).to render_template('api/v3/roles/index', formats: ['api'])
      end
    end

    context 'with roles available' do
      before do
        allow(Role).to receive(:givable).and_return(FactoryGirl.build_list(:role, 2))
      end

      it 'assigns an array with 2 roles' do
        get 'index', format: 'xml'
        expect(assigns(:roles).size).to eq 2
      end
    end
  end

end
