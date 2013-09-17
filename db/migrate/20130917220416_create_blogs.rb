class CreateBlogs < ActiveRecord::Migration
  def change

    create_table :blogs do |t|
      t.integer :user_id,   null: false
      t.string :subdomain,  null: false
      t.string :title,      null: false
      t.string :background
      t.string :background_color
      t.timestamps
    end

    User.all.each { |u| Blog.create! user_id: u.id, subdomain: u.subdomain, title: "#{u.name}'s Blog" }

    add_column :posts, :blog_id, :integer

    Post.reset_column_information
    Post.all.each do |p|
      ( p.destroy && next ) if p.user.blank?
      p.update_attribute :blog_id, p.user.blog.id
    end

    change_column :posts, :blog_id, :integer, :null => false
    remove_column :users, :subdomain

  end
end