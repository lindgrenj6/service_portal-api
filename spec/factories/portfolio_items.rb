FactoryBot.define do
  factory :portfolio_item, :traits => [:has_owner, :has_tenant] do
    sequence(:name)                 { |n| "PortfolioItem_name_#{n}" }
    sequence(:display_name)         { |n| "PortfolioItem_display_name_#{n}" }
    sequence(:description)          { |n| "PortfolioItem_description_#{n}" }
    sequence(:service_offering_ref) { |n| (111 + n).to_s }
    sequence(:service_offering_source_ref) { |n| (222 + n).to_s }

    portfolio
  end
end
