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

require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'api/v2/authentication/index.api.rabl' do
  before { params[:format] = 'xml' }

  describe 'authentication state' do
    before do
      assign(:authorization, Api::V2::AuthenticationController::AuthorizationData.new(true, nil))

      render
    end

    subject { response.body }

    it { expect(subject).to have_selector('authorization authorized', text: true) }
  end

  describe 'authenticated user' do
    before do
      assign(:authorization, Api::V2::AuthenticationController::AuthorizationData.new(nil, 12345))

      render
    end

    subject { response.body }

    it { expect(subject).to have_selector('authorization authenticated_user_id', text: 12345) }
  end
end
