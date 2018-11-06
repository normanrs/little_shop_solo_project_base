FactoryBot.define do
  factory :discount do
    range_low { 1 }
    range_high { 1 }
    percent { 1.5 }
    item { nil }
  end
end
