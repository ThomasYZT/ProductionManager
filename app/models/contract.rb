class Contract < ActiveRecord::Base
  belongs_to :user
  belongs_to :party_a
  belongs_to :party_b

  has_many :formals, class_name: 'Contract', foreign_key: 'initial_id'
  belongs_to :initial, class_name: 'Contract'

  has_many :contract_changes

  before_destroy :should_destroy?

  validates :breed, presence: true
  validates :cultivated_area , numericality: true
  validates :transplant_number, numericality: { only_integer: true }
  validates :purchase, numericality: { only_integer: true }

  def signing(params)
    save_or_update do
        self.party_a = PartyA.create!(params[:party_a])
        self.party_b = PartyB.create!(params[:party_b])
        save!
    end
  end

  def modify(params)
    
    if self.contract_no.slice(0,1) == 'I'

      save_or_update do
        self.attributes = collect_primitives params
        self.party_a.attributes = params['party_a']
        self.party_b.attributes = params['party_b']

        changes  = record_changes(self) + record_changes(party_a) + record_changes(party_b)

        ContractChange.create!(contents: changes, contract_id: self.id) unless changes.empty?

        self.party_a.save!
        self.party_b.save!
        save!
      end
    else

      supplemental = Contract.new(self.attributes)
      supplemental.id = nil
      collect_primitives(params).each {|k, v| supplemental[k] = v}

      supplemental.save
    end
  end

  def transform(params)
    formal_contract = Contract.new collect_primitives(params)

    formal_contract.contract_no = 'F-' + self.contract_no.
                                   slice(2, self.contract_no.length - 1)

    formal_contract.party_a = party_a
    formal_contract.party_b = party_b
    formal_contract.initial = self

    formal_contract.save
  end

  # Group by contract's prefix e.g 'I-' for initial contracts
  # 'F-' for formal contracts
  def self.analysis(station_id, start_time, end_time)
    sql = "SELECT COUNT(*) AS total ,SUM(purchase) AS purchase,
                  SUM(cultivated_area) AS area,
                  SUM(transplant_number) AS transplant
           FROM contracts c WHERE  c.created_at >= '#{start_time}'
                  AND c.created_at <= '#{end_time}'
                  AND c.user_id IN
                  (SELECT u.id FROM users u WHERE u.station_id = #{station_id})
                  GROUP BY substring(c.contract_no from 0 for 2)
                  ORDER BY substring(c.contract_no from 0 for 2) ASC;"
    ActiveRecord::Base.connection.execute(sql)
  end

  private

  def record_changes(record)
    str = ''
    if record.changed.size > 0
      record.changed.each do |field|
        str += field + ':' + record.attributes[field].to_s + '|'
      end
    end
    str
  end

  def should_destroy?
    formals.empty? 
  end

  def collect_primitives(params)
    params.reject { |k,v| k == 'party_a' || k == 'party_b' }
  end

  def save_or_update(&block)
    ActiveRecord::Base.transaction do
      begin
        block.call
      rescue ActiveRecord::RecordInvalid => invalid
        Rails.logger.error invalid.record.errors.messages.inspect
        raise ActiveRecord::Rollback
        false
      end
    end
  end


end
