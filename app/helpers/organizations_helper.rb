module OrganizationsHelper

  def organization_link(organization)
    organization ? link_to(organization, organization) : ''
  end

end
