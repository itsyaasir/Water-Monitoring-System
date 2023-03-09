/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    /**
     * Add altering commands here.
     *
     * Example:

     */
    await queryInterface.createTable('stats', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      userId: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: 'users',
          key: 'id',
        },
      },
      temperature: { type: Sequelize.FLOAT, allowNull: false },
      ph: Sequelize.FLOAT,
      turb: Sequelize.FLOAT,
      createdAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.NOW,
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.NOW,
      },
    });
  },

  async down(queryInterface, _Sequelize) {
    /**
     * Add reverting commands here.
     *
     * Example:
    */
    await queryInterface.dropTable('stats');
  },
};
