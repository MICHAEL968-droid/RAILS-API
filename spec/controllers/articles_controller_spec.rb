require 'rails_helper'
describe ArticlesController do   
    describe '#index' do
        subject {get :index}  # jaha jaha subject call kreege get inde x method waha calll hongi
        it 'should return success response' do  
            subject  
            expect(response).to have_http_status(:ok)
        end 
    
        it 'should return proper json'  do

            create_list :article, 2
            subject  
            Article.recent.each_with_index do |artic,index|
                expect(json_data[index]['attributes']).to eq({
                    "title" => artic.title,
                    "content" => artic.content,
                    "slug" => artic.slug        
                })
            end
        end

        it 'should return articles in the proper order' do 
            old_article = create :article 
            newer_article = create :article
            subject 
            expect(json_data.first['id']).to eq(newer_article.id.to_s)
            expect(json_data.last['id']).to eq(old_article.id.to_s) 
        end 

        it 'should paginate results' do 
            create_list :article, 3
            get :index, params: { page: 2, per_page: 1 }
            expect(json_data.length).to eq 1
            expect(json_data.first['id']).to eq(Article.recent.second.id.to_s)
        end 
    end 
    # describe '.recent' do 
    #     it 'should list recent article first' do 
    #         old_article = create :article 
    #         newer_article = create :article 
            
    #         expect(described_class.recent).to eq(
    #             [newer_article,old_article]
    #         )
    #         old_article.update_column :created_at, Time.now
    #         expect(described_class.recent).to eq(
    #             [ old_article, newer_article ])
    #     end 
    # end   
end    
